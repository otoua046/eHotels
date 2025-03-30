import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
import { CustomerService, Customer } from '../../../services/customer.service';
import { CustomerModalComponent } from './customer-modal/customer-modal.component';


@Component({
  selector: 'app-admin-customers',
  standalone: true,
  imports: [CommonModule, HttpClientModule, CustomerModalComponent, RouterModule],
  templateUrl: './admin-customers.component.html',
  styleUrls: ['./admin-customers.component.css']
})
export class AdminCustomersComponent implements OnInit {
  customers: Customer[] = [];
  loading = false;
  error: string = '';

  selectedCustomer: Customer | null = null;
  isModalOpen = false;
  isEditMode = false;

  constructor(private customerService: CustomerService) {}

  ngOnInit(): void {
    this.fetchCustomers();
  }

  fetchCustomers(): void {
    this.loading = true;
    this.customerService.getAllCustomers().subscribe({
      next: (data) => {
        this.customers = data;
        this.loading = false;
      },
      error: () => {
        this.error = 'Failed to load customers.';
        this.loading = false;
      }
    });
  }

  openInsertModal(): void {
    this.selectedCustomer = { FullName: '', Address: '', IDType: '' } as Customer;
    this.isEditMode = false;
    this.isModalOpen = true;
  }

  openEditModal(customer: Customer): void {
    this.selectedCustomer = { ...customer };
    this.isEditMode = true;
    this.isModalOpen = true;
  }

  handleModalClose(): void {
    this.isModalOpen = false;
    this.selectedCustomer = null;
  }

  handleCustomerSave(customerData: Customer): void {
    if (this.isEditMode) {
      this.customerService.updateCustomer(customerData).subscribe({
        next: () => this.fetchCustomers(),
        error: () => (this.error = 'Failed to update customer.')
      });
    } else {
      this.customerService.insertCustomer(customerData).subscribe({
        next: () => this.fetchCustomers(),
        error: () => (this.error = 'Failed to insert customer.')
      });
    }
    this.handleModalClose();
  }

  deleteCustomer(id: number): void {
    if (confirm('Are you sure you want to delete this customer?')) {
      this.customerService.deleteCustomer(id).subscribe({
        next: () => this.fetchCustomers(),
        error: () => (this.error = 'Failed to delete customer.')
      });
    }
  }
}