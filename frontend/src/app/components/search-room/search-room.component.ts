import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms'; 
import { RoomService } from '../../services/room.service';
import { Room } from '../../interfaces/room';
import { HttpClient } from '@angular/common/http';
import { BookingModalComponent } from '../booking-modal/booking-modal.component'; 
import { DirectRentingModalComponent } from '../directrenting-modal/directrenting-modal.component'; 
import { Router, RouterModule } from '@angular/router';



@Component({
  selector: 'app-search-room',
  standalone: true, 
  imports: [CommonModule, FormsModule, BookingModalComponent, DirectRentingModalComponent], 
  templateUrl: './search-room.component.html',
  styleUrls: ['./search-room.component.css']
})
export class SearchRoomComponent {
  filters: any = {
    start_date: '',
    end_date: '',
    capacity: '',
    area: '',
    hotel_chain: '',
    category: '',
    min_price: '',
    max_price: '',
    view: '',
    extendable: '',
    min_available_capacity: ''
  };

  rooms: Room[] = [];
  loading = false;
  error: string = '';
  availableCapacities: any[] = [];
  hotelChains: { ChainName: string }[] = [];

  constructor(private http: HttpClient, private router: Router, private roomService: RoomService) {}
 

  search() {
    this.loading = true;
    this.error = '';
    this.roomService.searchRooms(this.filters).subscribe({
      next: (data) => {
        this.rooms = data;
        this.loading = false;
      },
      error: (err) => {
        this.error = 'Failed to load rooms';
        this.loading = false;
      }
    });
  }

  userType: 'customer' | 'employee' | null = null;

  ngOnInit() {
    this.userType = localStorage.getItem('userType') as 'customer' | 'employee';
    
    this.roomService.getAvailableCapacityPerHotel().subscribe({
      next: (data) => {
        this.availableCapacities = data;
      },
      error: () => {
        console.error('Failed to load hotel capacity view');
      }
    });

    this.roomService.getHotelChains().subscribe({
    next: (data) => this.hotelChains = data,
    error: () => console.error('Failed to load hotel chains')
  
    });
    
  }

  selectedRoom: Room | null = null;

  openDirectRenting(room: Room) {
    this.selectedRoom = room;
    console.log('Selected room for direct renting:', this.selectedRoom); // Debug
  }

  openBooking(room: Room) {
    this.selectedRoom = room;
    console.log('Selected room for booking:', this.selectedRoom); // Debug
  }

  

  goToDashboard() {
    this.router.navigate(['/dashboard']);
  }

}