package service.Impl;

import org.springframework.stereotype.Service;
import persistence.domain.Record;
import persistence.mapper.RecordMapper;
import service.RecordService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class RecordServiceImpl implements RecordService{
    @Resource
    private RecordMapper recordMapper;
    @Override
    public void addRecord(Record record) {
        recordMapper.insert(record);
    }

    @Override
    public void deleteRecord(Record record) {

        recordMapper.deleteByPrimaryKey(record.getRecordId());
    }

    @Override
    public List<Record> getRecordByRelation(String sender, String receiver) {
        return recordMapper.selectByRelation(sender,receiver);
    }

    @Override
    public List<Record> getRecordToBroadcast() {
        return recordMapper.selectToBroadcast("");
    }

    @Override
    public List<Record> getRecordToBroadcast(String receiver) {
        return recordMapper.selectToBroadcast(receiver);
    }

}
