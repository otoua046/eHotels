import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-customer-modal',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './customer-modal.component.html',
  styleUrls: ['./customer-modal.component.css']
})
export class CustomerModalComponent {
  @Input() customer: any = { FullName: '', Address: '', IDType: '' };
  @Input() isEdit: boolean = false;
  @Output() close = new EventEmitter<void>();
  @Output() saveCustomer = new EventEmitter<any>();

  cancel() {
    this.close.emit();
  }

  save() {
    this.saveCustomer.emit(this.customer);
  }
}