import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { StatisticsService } from '../../services/statistics.service';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  selector: 'app-statistics',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './statistics.component.html',
  styleUrls: ['./statistics.component.css']
})
export class StatisticsComponent {
  roomsPerArea: any[] = [];
  capacityPerHotel: any[] = [];
  loading = true;
  error: string | null = null;

  constructor(private http: HttpClient, private router: Router, private statsService: StatisticsService) {}

  ngOnInit() {
    this.fetchStats();
  }

  fetchStats() {
    this.loading = true;
    this.statsService.getAvailableRoomsPerArea().subscribe({
      next: (data) => this.roomsPerArea = data,
      error: () => this.error = 'Failed to load available rooms per area'
    });

    this.statsService.getAvailableCapacityPerHotel().subscribe({
      next: (data) => this.capacityPerHotel = data,
      error: () => this.error = 'Failed to load available capacity per hotel',
      complete: () => this.loading = false
    });

  
  }

  goToDashboard() {
    this.router.navigate(['/dashboard']);
  }
}