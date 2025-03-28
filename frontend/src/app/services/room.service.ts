import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Room } from '../interfaces/room';

@Injectable({
  providedIn: 'root',
})
export class RoomService {
  private apiUrl = 'http://localhost:8000/api/search_rooms.php';

  constructor(private http: HttpClient) {}

  searchRooms(filters: any): Observable<Room[]> {
    let params = new HttpParams();
    Object.keys(filters).forEach(key => {
      if (filters[key] !== null && filters[key] !== '') {
        params = params.set(key, filters[key]);
      }
    });
    return this.http.get<Room[]>(this.apiUrl, { params });
  }
}