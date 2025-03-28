import { Component } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-landing-page',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './landing-page.component.html',
  styleUrls: ['./landing-page.component.css']
})
export class LandingPageComponent {

  constructor(private router: Router) {}

  setUserType(type: 'customer' | 'employee') {
    localStorage.setItem('userType', type);
  }

  continueAsCustomer() {
    this.setUserType('customer');
    this.router.navigate(['/search']);
  }

  loginAsEmployee() {
    const password = prompt('Enter employee password:');
    if (password === 'admin123') {
      this.setUserType('employee');
      this.router.navigate(['/dashboard']);
    } else {
      alert('Incorrect password. Access denied.');
    }
  }
}
