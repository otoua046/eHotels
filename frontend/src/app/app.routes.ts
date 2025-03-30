import { Routes } from '@angular/router';
import { SearchRoomComponent } from './components/search-room/search-room.component';
import { LandingPageComponent } from './components/landing-page/landing-page.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { AdminComponent } from './components/admin/admin.component';
import { AdminCustomersComponent } from './components/admin/admin-customers/admin-customers.component';
import { AdminEmployeesComponent } from './components/admin/admin-employees/admin-employees.component';
import { AdminHotelsComponent } from './components/admin/admin-hotels/admin-hotels.component';
import { AdminRoomsComponent } from './components/admin/admin-rooms/admin-rooms.component';

export const routes: Routes = [
  { path: '', component: LandingPageComponent },
  { path: 'search', component: SearchRoomComponent },
  { path: 'dashboard', component: DashboardComponent},
  { path: 'statistics', loadComponent: () => import('./components/statistics/statistics.component').then(m => m.StatisticsComponent) },
  { path: 'admin', component: AdminComponent },
  { path: 'admin/customers', component: AdminCustomersComponent },
  { path: 'admin/employees', component: AdminEmployeesComponent },
  { path: 'admin/hotels', component: AdminHotelsComponent },
  { path: 'admin/rooms', component: AdminRoomsComponent },
];