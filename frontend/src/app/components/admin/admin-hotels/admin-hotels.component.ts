import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { HotelService } from '../../../services/hotel.service';
import { Hotel } from '../../../interfaces/hotel';
import { HotelModalComponent } from './hotel-modal/hotel-modal.component';
import { RouterModule } from '@angular/router';


@Component({
  selector: 'app-admin-hotel',
  standalone: true,
  imports: [CommonModule, HttpClientModule, HotelModalComponent, RouterModule],
  templateUrl: './admin-hotels.component.html',
  styleUrls: ['./admin-hotels.component.css']
})
export class AdminHotelsComponent implements OnInit {
  hotels: Hotel[] = [];
  loading = false;
  error: string = '';

  selectedHotel: Hotel | null = null;
  isModalOpen = false;
  isEditMode = false;

  constructor(private hotelService: HotelService) {}

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

  openInsertModal(): void {
    this.selectedHotel = {HotelName: '', Address: '', PhoneNumber: '', Category: ''} as Hotel;
    this.isEditMode = false;
    this.isModalOpen = true;
  }

  openEditModal(hotel: Hotel): void {
    this.selectedHotel = { ...hotel };
    this.isEditMode = true;
    this.isModalOpen = true;
  }

  handleModalClose(): void {
    this.isModalOpen = false;
    this.selectedHotel = null;
  }

  handleHotelSave(hotelData: Hotel): void {
    if (this.isEditMode) {
      this.hotelService.updateHotel(hotelData).subscribe({
        next: () => this.fetchHotel(),
        error: () => (this.error = 'Failed to update hotel.')
      });
    } else {
      this.hotelService.insertHotel(hotelData).subscribe({
        next: () => this.fetchHotel(),
        error: () => (this.error = 'Failed to insert hotel.')
      });
    }
    this.handleModalClose();
  }

  deleteHotel(id: number): void {
    if (confirm('Are you sure you want to delete this hotel? Note: All employees of the hotel will also be deleted')) {
      this.hotelService.deleteHotel(id).subscribe({
        next: () => this.fetchHotel(),
        error: () => (this.error = 'Failed to delete hotel.')
      });
    }
  }
}