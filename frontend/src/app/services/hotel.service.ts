import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface Hotel {
    HotelID: number;
    ChainID: number;
    HotelName: string;
    Address: string;
    Email: string;
    PhoneNumber: string;
    Category: string;
    NumberOfRooms: number;
    ChainName: string;
}

@Injectable({
  providedIn: 'root'
})
export class HotelService {
  private baseUrl = 'http://localhost:8000/api';

  constructor(private http: HttpClient) {}

  getAllHotels(): Observable<Hotel[]> {
    return this.http.get<Hotel[]>(`${this.baseUrl}/get_hotels.php`);
  }
  
  getAllChains(): Observable<Hotel[]> {
    return this.http.get<Hotel[]>(`${this.baseUrl}/get_all_hotel_chains.php`);
  }

  insertHotel(hotel: Hotel): Observable<any> {
    return this.http.post(`${this.baseUrl}/create_hotel.php`, hotel);
  }

  updateHotel(hotel: Hotel): Observable<any> {
    return this.http.post(`${this.baseUrl}/update_hotel.php`, hotel);
  }

  deleteHotel(hotelId: number): Observable<any> {
    const form = new FormData();
    form.append('HotelID', hotelId.toString());
    return this.http.post(`${this.baseUrl}/delete_hotel.php`, form);
  }
}