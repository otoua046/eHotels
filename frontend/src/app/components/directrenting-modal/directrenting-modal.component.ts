import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-direct-renting-modal',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './directrenting-modal.component.html',
  styleUrls: ['./directrenting-modal.component.css']
})
export class DirectRentingModalComponent {
  @Input() roomId!: number;
  @Input() checkInDate!: string;
  @Input() checkOutDate!: string;

  step: number = 1;
  name: string = '';
  address: string = '';
  idType: string = 'SSN';
  customerExists: boolean | null = null;
  rentingSuccess: boolean = false;
  rentingError: string | null = null;
  isSubmitting: boolean = false;
  creditCard: string = '';

  constructor(private http: HttpClient) {}

  checkCustomer() {
    if (!this.name) return;

    this.http.get<any>(`http://localhost:8000/api/check_customer.php?name=${encodeURIComponent(this.name)}`)
      .subscribe(response => {
        this.customerExists = response.exists;
        if (response.exists) {
          this.submitRenting(response.customerID);
        } else {
          this.step = 2;
        }
      });
  }

  submitRenting(customerId: number | null = null) {
    this.isSubmitting = true;

    if (customerId != null) {
      const payload = {
        roomId: this.roomId,
        checkInDate: this.checkInDate,
        checkOutDate: this.checkOutDate,
        customerId: customerId,
        employeeId: 1,
        creditCard: this.creditCard
      };

      this.http.post('http://localhost:8000/api/direct_renting.php', payload).subscribe({
        next: () => this.handleSuccess(),
        error: err => this.handleError(err)
      });

    } else {
      if (!this.name || !this.address || !this.idType) {
        this.rentingError = 'Please fill in all fields.';
        this.isSubmitting = false;
        return;
      }

      const customerPayload = {
        name: this.name,
        address: this.address,
        idType: this.idType
      };

      this.http.post('http://localhost:8000/api/create_customer.php', customerPayload).subscribe({
        next: (res: any) => {
          const newCustomerId = res.customerID;
          if (!newCustomerId) {
            this.rentingError = 'Customer creation succeeded but no ID returned.';
            this.isSubmitting = false;
            return;
          }

          const payload = {
            roomId: this.roomId,
            checkInDate: this.checkInDate,
            checkOutDate: this.checkOutDate,
            customerId: newCustomerId,
            employeeId: 1,
            creditCard: this.creditCard
          };

          this.http.post('http://localhost:8000/api/direct_renting.php', payload).subscribe({
            next: () => this.handleSuccess(),
            error: err => this.handleError(err)
          });
        },
        error: err => this.handleError(err)
      });
    }
  }

  handleSuccess() {
    this.rentingSuccess = true;
    this.rentingError = null;
    this.isSubmitting = false;
  }

  handleError(err: any) {
    this.rentingSuccess = false;
    this.rentingError = err.error?.error || 'Renting failed.';
    this.isSubmitting = false;
  }

  @Output() closed = new EventEmitter<void>();

  closeModal() {
    this.closed.emit();
  }
}
