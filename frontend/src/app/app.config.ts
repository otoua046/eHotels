import { provideHttpClient } from '@angular/common/http';
import { provideRouter } from '@angular/router';
import { importProvidersFrom } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { LandingPageComponent } from './components/landing-page/landing-page.component';
import { SearchRoomComponent } from './components/search-room/search-room.component';
import { BookingModalComponent } from './components/booking-modal/booking-modal.component';
import { AdminComponent } from './components/admin/admin.component';
import { AdminCustomersComponent } from './components/admin/admin-customers/admin-customers.component';
import { AdminEmployeesComponent } from './components/admin/admin-employees/admin-employees.component';
import { AdminHotelsComponent } from './components/admin/admin-hotels/admin-hotels.component';
import { AdminRoomsComponent } from './components/admin/admin-rooms/admin-rooms.component';


export const appConfig = {
  providers: [
    provideRouter([
      { path: '', component: LandingPageComponent },
      { path: 'search', component: SearchRoomComponent },
      { path: 'dashboard', loadComponent: () => import('./components/dashboard/dashboard.component').then(m => m.DashboardComponent) },
      { path: 'bookings', loadComponent: () => import('./components/bookings/bookings.component').then(m => m.BookingsComponent) },
      { path: 'rentings', loadComponent: () => import('./components/rentings/rentings.component').then(m => m.RentingsComponent) },
      { path: 'statistics', loadComponent: () => import('./components/statistics/statistics.component').then(m => m.StatisticsComponent) },
      { path: 'admin', loadComponent: () => import('./components/admin/admin.component').then(m => m.AdminComponent) },
      { path: 'admin/customers', component: AdminCustomersComponent },
      { path: 'admin/employees', component: AdminEmployeesComponent },
      { path: 'admin/hotels', component: AdminHotelsComponent },
      { path: 'admin/rooms', component: AdminRoomsComponent },
    ]),
    
    provideHttpClient(),
    importProvidersFrom(FormsModule)
  ]
};