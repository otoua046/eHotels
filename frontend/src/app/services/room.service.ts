import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Room } from '../interfaces/room';

@Injectable({
  providedIn: 'root',
})
export class RoomService {

private baseUrl = 'http://localhost:8000/api';

  constructor(private http: HttpClient) {}

  searchRooms(filters: any): Observable<Room[]> {
    let params = new HttpParams();
    Object.keys(filters).forEach(key => {
      if (filters[key] !== null && filters[key] !== '') {
        params = params.set(key, filters[key]);
      }
    });
    return this.http.get<Room[]>(`${this.baseUrl}/search_rooms.php`, { params });
  }

  getAvailableCapacityPerHotel() {
    return this.http.get<any[]>(`${this.baseUrl}/available_capacity_per_hotel.php`);
  }
  
  getHotelChains() {
    return this.http.get<{ ChainName: string }[]>(`${this.baseUrl}/get_all_hotel_chains.php`);
  }

  getAllRooms(): Observable<Room[]> {
    return this.http.get<Room[]>(`${this.baseUrl}/search_rooms.php`);
  }
  

  insertRoom(room: Room): Observable<any> {
    return this.http.post(`${this.baseUrl}/create_room.php`, room);
  }

  updateRoom(room: Room): Observable<any> {
    return this.http.post(`${this.baseUrl}/update_room.php`, room);
  }

  deleteRoom(roomId: number): Observable<any> {
    const form = new FormData();
    form.append('RoomID', roomId.toString());
    return this.http.post(`${this.baseUrl}/delete_room.php`, form);
  }
}