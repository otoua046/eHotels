import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface Employee {
  EmployeeID: number;
  HotelID: number;
  FullName: string;
  Address: string;
  SSN_SIN: string;
  Role: string;
  HotelName: string;

}

@Injectable({
  providedIn: 'root'
})
export class EmployeeService {
  private baseUrl = 'http://localhost:8000/api';

  constructor(private http: HttpClient) {}

  getAllEmployees(): Observable<Employee[]> {
    return this.http.get<Employee[]>(`${this.baseUrl}/get_employees.php`);
  }

  insertEmployee(employee: Employee): Observable<any> {
    return this.http.post(`${this.baseUrl}/create_employee.php`, employee);
  }

  updateEmployee(employee: Employee): Observable<any> {
    return this.http.post(`${this.baseUrl}/update_employee.php`, employee);
  }

  deleteEmployee(employeeId: number): Observable<any> {
    const form = new FormData();
    form.append('EmployeeID', employeeId.toString());
    return this.http.post(`${this.baseUrl}/delete_employee.php`, form);
  }
}