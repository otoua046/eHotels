import { Component, Input, Output, EventEmitter, input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-booking-modal',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './booking-modal.component.html',
  styleUrls: ['./booking-modal.component.css']
})
export class BookingModalComponent {
  @Input() roomId!: number;
  @Input() startDate!: string;
  @Input() endDate!: string;
  

  step: number = 1;
  name: string = '';
  address: string = '';
  idType: string = 'SSN';
  customerExists: boolean | null = null;
  bookingSuccess: boolean = false;
  bookingError: string | null = null;
  isSubmitting: boolean = false;

  constructor(private http: HttpClient) {}

  checkCustomer() {
    if (!this.name) return;

    this.http.get<any>(`http://localhost:8000/api/check_customer.php?name=${encodeURIComponent(this.name)}`)
      .subscribe(response => {
        this.customerExists = response.exists;
        if (response.exists) {
          this.submitBooking(response.customerID);
        } else {
          this.step = 2; // Show the extended form for new customer
        }
      });
  }

  submitBooking(customerId: number | null = null) {
    this.isSubmitting = true;
  
    if (customerId != null) {
      // Existing customer
      const payload = {
        roomId: this.roomId,
        startDate: this.startDate,
        endDate: this.endDate,
        customerId: customerId
      };
  
      this.http.post('http://localhost:8000/api/create_booking.php', payload).subscribe({
        next: () => this.handleSuccess(),
        error: err => this.handleError(err)
      });
  
    } else {
      // Ensure new customer data is present
      if (!this.name || !this.address || !this.idType) {
        this.bookingError = 'Please fill in all fields.';
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
            this.bookingError = 'Customer creation succeeded but no ID returned.';
            this.isSubmitting = false;
            return;
          }
  
          const payload = {
            roomId: this.roomId,
            startDate: this.startDate,
            endDate: this.endDate,
            customerId: newCustomerId
          };
  
          this.http.post('http://localhost:8000/api/create_booking.php', payload).subscribe({
            next: () => this.handleSuccess(),
            error: err => this.handleError(err)
          });
        },
        error: err => this.handleError(err)
      });
    }
  }

  handleSuccess() {
    this.bookingSuccess = true;
    this.bookingError = null;
    this.isSubmitting = false;
  }

  handleError(err: any) {
    this.bookingSuccess = false;
    this.bookingError = err.error?.error || 'Booking failed.';
    this.isSubmitting = false;
  }

  @Output() closed = new EventEmitter<void>();

  closeModal() {
    this.closed.emit();
  }
}