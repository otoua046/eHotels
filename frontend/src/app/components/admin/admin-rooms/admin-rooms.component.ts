import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { RoomService } from '../../../services/room.service';
import { Room } from '../../../interfaces/room';
import { RoomModalComponent } from './room-modal/room-modal.component';
import { RouterModule } from '@angular/router';


@Component({
  selector: 'app-admin-room',
  standalone: true,
  imports: [CommonModule, HttpClientModule, RoomModalComponent, RouterModule],
  templateUrl: './admin-rooms.component.html',
  styleUrls: ['./admin-rooms.component.css']
})
export class AdminRoomsComponent implements OnInit {
  rooms: Room[] = [];
  loading = false;
  error: string = '';

  selectedRoom: Partial<Room> | null = null;
  isModalOpen = false;
  isEditMode = false;

  constructor(private roomService: RoomService) {}

  ngOnInit(): void {
    this.fetchRoom();
  }

  fetchRoom(): void {
    this.loading = true;
    this.roomService.getAllRooms().subscribe({
      next: (data) => {
        this.rooms = data;
        this.loading = false;
      },
      error: () => {
        this.error = 'Failed to load rooms.';
        this.loading = false;
      }
    });
  }

  openInsertModal(): void {
    this.selectedRoom = {
      RoomNumber: 0,
      Price: 0,
      Capacity: '',
      Amenities: '',
      ViewType: 'None',
      CanBeExtended: false,
      HasDamage: false,
      ProblemDescription: '',
    } as Room;

    this.isEditMode = false;
    this.isModalOpen = true;
  }

  openEditModal(room: any): void {
    this.selectedRoom = {
      RoomID: room.RoomID,
      RoomNumber: room.RoomNumber,
      Price: room.Price,
      Amenities: room.Amenities,
      Capacity: room.Capacity,
      ViewType: room.ViewType,
      CanBeExtended: room.CanBeExtended,
      HasDamage: room.HasDamage,
      ProblemDescription: room.ProblemDescription,
      HotelID: room.HotelID
    };
    this.isEditMode = true;
    this.isModalOpen = true;
  }

  handleModalClose(): void {
    this.isModalOpen = false;
    this.selectedRoom = null;
  }

  handleRoomSave(roomData: Room): void {
    if (this.isEditMode) {
      this.roomService.updateRoom(roomData).subscribe({
        next: () => this.fetchRoom(),
        error: () => (this.error = 'Failed to update room.')
      });
    } else {
      this.roomService.insertRoom(roomData).subscribe({
        next: () => this.fetchRoom(),
        error: () => (this.error = 'Failed to insert room.')
      });
    }
    this.handleModalClose();
  }

  deleteRoom(id: number): void {
    if (confirm('Are you sure you want to delete this rrom?')) {
      this.roomService.deleteRoom(id).subscribe({
        next: () => this.fetchRoom(),
        error: () => (this.error = 'Failed to delete room.')
      });
    }
  }
}