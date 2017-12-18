package service;

import persistence.domain.Record;
import persistence.mapper.RecordMapper;

public interface RecordService {

    void addRecord(Record record);

    void deleteRecord(Record record);

    void getRecordByTime(int key);
}
