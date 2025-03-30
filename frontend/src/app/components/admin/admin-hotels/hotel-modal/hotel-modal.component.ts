import { Component, Input, Output, EventEmitter, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Hotel } from '@app/interfaces/hotel';
import { HotelService } from '@app/services/hotel.service';


@Component({
  selector: 'app-hotel-modal',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './hotel-modal.component.html',
  styleUrls: ['./hotel-modal.component.css']
})
export class HotelModalComponent implements OnInit {
  @Input() hotel: any = { ChainID: '', HotelName: '', Address: '', Email: '', PhoneNumber: '', Category: '' };
  @Input() isEdit: boolean = false;
  @Output() close = new EventEmitter<void>();
  @Output() saveHotel = new EventEmitter<any>();

  chains: any[] = [];
  loading = false;
  error: string = '';

  constructor(private hotelService: HotelService) {}

  ngOnInit(): void {
    this.fetchHotel();
  }

  fetchHotel(): void {
    this.loading = true;
    this.hotelService.getAllChains().subscribe({
      next: (data) => {
        this.chains = data;
        this.loading = false;
      },
      error: () => {
        this.error = 'Failed to load hotel.';
        this.loading = false;
      }
    });
  }
  cancel() {
    this.close.emit();
  }

  save() {
    this.saveHotel.emit(this.hotel);
  }
}