import { Routes } from '@angular/router';
import { SearchRoomComponent } from './components/search-room/search-room.component';
import { LandingPageComponent } from './components/landing-page/landing-page.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';

export const routes: Routes = [
  { path: '', component: LandingPageComponent },
  { path: 'search', component: SearchRoomComponent },
  { path: 'dashboard', component: DashboardComponent},
  { path: 'statistics', loadComponent: () => import('./components/statistics/statistics.component').then(m => m.StatisticsComponent) }
];