import { Component, Input, Output, EventEmitter, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Room } from '@app/interfaces/room';
import { RoomService } from '@app/services/room.service';
import { HotelService } from '@app/services/hotel.service';


@Component({
  selector: 'app-room-modal',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './room-modal.component.html',
  styleUrls: ['./room-modal.component.css']
})
export class RoomModalComponent implements OnInit {
  @Input() room: any = { HotelName: '', RoomNumber: '', Price: '', Amenities: '', Capacity: '', ViewType: '', CanBeExtended: '', HasDamage: '', ProblemDescription: '' };
  @Input() isEdit: boolean = false;
  @Output() close = new EventEmitter<void>();
  @Output() saveRoom = new EventEmitter<any>();

  hotels: any[] = [];
  loading = false;
  error: string = '';

  constructor(private roomService: RoomService, private hotelService: HotelService) {}

  ngOnInit(): void {
    this.fetchHotel();
  }

  fetchHotel(): void {
    this.loading = true;
    this.hotelService.getAllHotels().subscribe({
      next: (data) => {
        this.hotels = data;
        this.loading = false;
      },
      error: () => {
        this.error = 'Failed to load hotels.';
        this.loading = false;
      }
    });
  }
  cancel() {
    this.close.emit();
  }

  save() {
    this.saveRoom.emit(this.room);
  }
}