package com.tourtravel.converter;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

import com.tourtravel.model.Booking.BookingStatus;

@Converter(autoApply = true)
public class BookingStatusConverter implements AttributeConverter<BookingStatus, String> {
    @Override
    public String convertToDatabaseColumn(BookingStatus status) {
        return status.name();
    }

    @Override
    public BookingStatus convertToEntityAttribute(String dbData) {
        return BookingStatus.fromString(dbData);
    }
}