import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-rent-modal',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './rent-modal.component.html',
  styleUrls: ['./rent-modal.component.css']
})
export class RentModalComponent {
  @Input() bookingId!: number;
  @Input() roomId!: number;
  @Input() customerId!: number;

  creditCardNumber: string = '';
  rentSuccess = false;
  rentError: string | null = null;
  isSubmitting = false;

  @Output() closed = new EventEmitter<void>();

  constructor(private http: HttpClient) {}

  confirmRenting() {
    this.isSubmitting = true;
    const payload = {
      bookingId: this.bookingId,
      roomId: this.roomId,
      customerId: this.customerId,
      employeeId: 1, // temporary until session-based auth is added
      creditCard: this.creditCardNumber
    };

    this.http.post('http://localhost:8000/api/convert_booking_to_renting.php', payload).subscribe({
      next: () => {
        this.rentSuccess = true;
        this.rentError = null;
        this.isSubmitting = false;
      },
      error: err => {
        this.rentError = err.error?.error || 'Renting failed.';
        this.rentSuccess = false;
        this.isSubmitting = false;
      }
    });
  }

  closeModal() {
    this.closed.emit();
  }
}
