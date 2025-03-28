export interface Room {
    RoomID: number;
    RoomNumber: number;
    Price: number;
    Capacity: string;
    ViewType: 'Sea' | 'Mountain' | 'None';
    CanBeExtended: boolean;
    HasDamage: boolean;
    HotelID: number;
    HotelName: string;
    HotelAddress: string;
    HotelEmail: string;
    HotelPhone: string;
    Category: string; // e.g. "1-star", "5-star"
    CentralOfficeAddress: string;
  }