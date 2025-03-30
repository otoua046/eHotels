import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { EmployeeService } from '../../../services/employee.service';
import { Employee } from '../../../interfaces/employee';
import { RouterModule } from '@angular/router';
import { EmployeeModalComponent } from './employee-modal/employee-modal.component';


@Component({
  selector: 'app-admin-employee',
  standalone: true,
  imports: [CommonModule, HttpClientModule, EmployeeModalComponent, RouterModule],
  templateUrl: './admin-employees.component.html',
  styleUrls: ['./admin-employees.component.css']
})
export class AdminEmployeesComponent implements OnInit {
  employees: Employee[] = [];
  loading = false;
  error: string = '';

  selectedEmployee: Employee | null = null;
  isModalOpen = false;
  isEditMode = false;

  constructor(private employeeService: EmployeeService) {}

  ngOnInit(): void {
    this.fetchEmployee();
  }

  fetchEmployee(): void {
    this.loading = true;
    this.employeeService.getAllEmployees().subscribe({
      next: (data) => {
        this.employees = data;
        this.loading = false;
      },
      error: () => {
        this.error = 'Failed to load employees.';
        this.loading = false;
      }
    });
  }

  openInsertModal(): void {
    this.selectedEmployee = {FullName: '', Address: '', SSN_SIN: '', Role: '' } as Employee;
    this.isEditMode = false;
    this.isModalOpen = true;
  }

  openEditModal(employee: Employee): void {
    this.selectedEmployee = { ...employee };
    this.isEditMode = true;
    this.isModalOpen = true;
  }

  handleModalClose(): void {
    this.isModalOpen = false;
    this.selectedEmployee = null;
  }

  handleEmployeeSave(employeeData: Employee): void {
    if (this.isEditMode) {
      this.employeeService.updateEmployee(employeeData).subscribe({
        next: () => this.fetchEmployee(),
        error: () => (this.error = 'Failed to update employee.')
      });
    } else {
      this.employeeService.insertEmployee(employeeData).subscribe({
        next: () => this.fetchEmployee(),
        error: () => (this.error = 'Failed to insert employee.')
      });
    }
    this.handleModalClose();
  }

  deleteEmployee(id: number): void {
    if (confirm('Are you sure you want to delete this employee?')) {
      this.employeeService.deleteEmployee(id).subscribe({
        next: () => this.fetchEmployee(),
        error: () => (this.error = 'Failed to delete employee.')
      });
    }
  }
}