import { Component, Input, Output, EventEmitter, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Employee } from '@app/interfaces/employee';
import { EmployeeService } from '@app/services/employee.service';
import { HotelService } from '@app/services/hotel.service';


@Component({
  selector: 'app-employee-modal',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './employee-modal.component.html',
  styleUrls: ['./employee-modal.component.css']
})
export class EmployeeModalComponent implements OnInit {
  @Input() employee: any = { HotelName: '', FullName: '', Address: '', SSN_SIN: '', Role: '' };
  @Input() isEdit: boolean = false;
  @Output() close = new EventEmitter<void>();
  @Output() saveEmployee = new EventEmitter<any>();

  hotels: any[] = [];
  loading = false;
  error: string = '';

  constructor(private employeeService: EmployeeService, private hotelService: HotelService) {}

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
        this.error = 'Failed to load employees.';
        this.loading = false;
      }
    });
  }
  cancel() {
    this.close.emit();
  }

  save() {
    this.saveEmployee.emit(this.employee);
  }
}