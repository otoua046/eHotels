import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DirectRentingModalComponent } from './directrenting-modal.component';

describe('DirectrentingModalComponent', () => {
  let component: DirectRentingModalComponent;
  let fixture: ComponentFixture<DirectRentingModalComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DirectRentingModalComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DirectRentingModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
