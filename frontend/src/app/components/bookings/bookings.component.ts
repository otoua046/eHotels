import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { RentModalComponent } from "../rent-modal/rent-modal.component";

@Component({
  selector: 'app-bookings',
  standalone: true,
  imports: [CommonModule, RentModalComponent, RentModalComponent],
  templateUrl: './bookings.component.html',
  styleUrls: ['./bookings.component.css']
})
export class BookingsComponent implements OnInit {
  bookings: any[] = [];
  error: string | null = null;

  constructor(private http: HttpClient, private router: Router) {}

  ngOnInit(): void {
    const userType = localStorage.getItem('userType');
    if (userType !== 'employee') {
      this.router.navigate(['/']); // redirect if not employee
      return;
    }

    this.fetchBookings();
  }

  fetchBookings() {
    this.http.get<any[]>('http://localhost:8000/api/show_bookings.php').subscribe({
      next: (res) => {
        this.bookings = res;
        this.error = null;
      },
      error: (err) => {
        this.error = 'Failed to load bookings.';
      }
    });
  }

  selectedBooking: any = null;

  rentNow(booking: any) {
    this.selectedBooking = booking;
  }

  goToDashboard() {
    this.router.navigate(['/dashboard']);
  }
  
}
