import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class StatisticsService {
  private API_URL = 'http://localhost:8000/api';

  constructor(private http: HttpClient) {}

  getAvailableRoomsPerArea(): Observable<any[]> {
    return this.http.get<any[]>(`${this.API_URL}/available_rooms_per_area.php`);
  }

  getAvailableCapacityPerHotel(): Observable<any[]> {
    return this.http.get<any[]>(`${this.API_URL}/available_capacity_per_hotel.php`);
  }
}