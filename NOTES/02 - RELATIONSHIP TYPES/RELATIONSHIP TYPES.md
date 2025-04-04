
| Relationship            | Type                   | Explanation                                                                                               |
| ----------------------- | ---------------------- | --------------------------------------------------------------------------------------------------------- |
| Customer — Sale         | 1:M                    | A customer can make many purchases.                                                                       |
| Employee — Sale         | 1:M                    | A salesperson can handle many sales.                                                                      |
| Sale — Vehicle          | M:N (via bridge table) | A sale can include multiple vehicles, and a vehicle can be part of a sale (resolved using `SaleVehicle`). |
| Sale — Finance          | 1:1                    | Each sale can have zero or one financing agreement.                                                       |
| Sale — Insurance        | 1:1                    | Each sale can have zero or one insurance record.                                                          |
| Vehicle — ServiceRecord | 1:M                    | A vehicle can have multiple service records.                                                              |
