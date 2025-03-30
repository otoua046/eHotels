export interface Room {
    RoomID: number;
    RoomNumber: number;
    Price: number;
    Amenities: string;
    Capacity: string;
    ViewType: 'Sea' | 'Mountain' | 'None';
    CanBeExtended: boolean;
    HasDamage: boolean;
    ProblemDescription: string;
    HotelID: number;
    HotelName: string;
    HotelAddress: string;
    HotelEmail: string;
    HotelPhone: string;
    Category: string; // e.g. "1-star", "5-star"
    CentralOfficeAddress: string;
    AvailableCapacity: number;
    HotelChain: string;
  }