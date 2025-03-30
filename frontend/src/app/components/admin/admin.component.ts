import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-admin',
  standalone: true,
  imports: [CommonModule, RouterModule ],
  templateUrl: './admin.component.html',
  styleUrl: './admin.component.css'
})
export class AdminComponent {

  logout(): void {
    localStorage.removeItem('userType'); // or any admin session key
    window.location.href = '/'; // or use the Angular Router to navigate
  }

}
