import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface Customer {
  CustomerID?: number; // Optional for inserts
  FullName: string;
  Address: string;
  IDType: string;
}

@Injectable({
  providedIn: 'root'
})
export class CustomerService {
  private baseUrl = 'http://localhost:8000/api';

  constructor(private http: HttpClient) {}

  getAllCustomers(): Observable<Customer[]> {
    return this.http.get<Customer[]>(`${this.baseUrl}/get_customers.php`);
  }

  insertCustomer(customer: Customer): Observable<any> {
    return this.http.post(`${this.baseUrl}/create_customer.php`, customer);
  }

  updateCustomer(customer: Customer): Observable<any> {
    return this.http.post(`${this.baseUrl}/update_customer.php`, customer);
  }

  deleteCustomer(customerId: number): Observable<any> {
    const form = new FormData();
    form.append('CustomerID', customerId.toString());
    return this.http.post(`${this.baseUrl}/delete_customer.php`, form);
  }
}