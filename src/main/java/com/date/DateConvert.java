package com.date;

import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateConvert implements Converter<String, Date> {
    private String dataPa="yyyy-MM-dd HH:mm:ss";
    @Override
    public Date convert(String source){
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat(dataPa);
        try {
            return simpleDateFormat.parse(source);
        }catch (ParseException e){
            throw new IllegalArgumentException("转化失败");
        }
    }
}
