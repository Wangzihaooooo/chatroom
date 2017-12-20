package service;

import persistence.domain.Record;
import persistence.mapper.RecordMapper;

import java.util.List;

public interface RecordService {

    void addRecord(Record record);

    void deleteRecord(Record record);

    List<Record> getRecordByRelation(String sender, String receiver);

    List<Record> getRecordToBroadcast();

    List<Record> getRecordToBroadcast(String receiver);
}
