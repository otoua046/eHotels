import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';

@Component({
  selector: 'app-rentings',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './rentings.component.html',
  styleUrls: ['./rentings.component.css']
})
export class RentingsComponent implements OnInit {
  rentings: any[] = [];
  error: string | null = null;

  constructor(private http: HttpClient, private router: Router) {}

  ngOnInit(): void {
    const userType = localStorage.getItem('userType');
    if (userType !== 'employee') {
      this.router.navigate(['/']);
      return;
    }

    this.fetchRentings();
  }

  fetchRentings() {
    this.http.get<any[]>('http://localhost:8000/api/show_rentings.php').subscribe({
      next: res => {
        this.rentings = res;
      },
      error: () => {
        this.error = 'Failed to load rentings.';
      }
    });
  }

  selectedRentingId: number | null = null;
showConfirmModal = false;

openConfirmModal(rentingId: number) {
  this.selectedRentingId = rentingId;
  this.showConfirmModal = true;
}

closeConfirmModal() {
  this.showConfirmModal = false;
  this.selectedRentingId = null;
}

confirmCheckOut() {
  if (this.selectedRentingId !== null) {
    this.checkOut(this.selectedRentingId);
    this.closeConfirmModal();
  }
}

  goToDashboard() {
    this.router.navigate(['/dashboard']);
  }

  checkOut(rentingId: number) {
    this.http.post('http://localhost:8000/api/checkout_renting.php', { rentingId }).subscribe({
      next: () => {
        this.rentings = this.rentings.filter(r => r.RentingID !== rentingId);
      },
      error: () => {
        alert('Checkout failed.');
      }
    });
    
    
  }
}