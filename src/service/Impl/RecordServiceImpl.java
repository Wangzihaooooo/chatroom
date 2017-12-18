package service.Impl;

import org.springframework.stereotype.Service;
import persistence.domain.Record;
import persistence.mapper.RecordMapper;
import service.RecordService;

import javax.annotation.Resource;

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
    public void getRecordByTime(int key) {

        recordMapper.selectByPrimaryKey(key);
    }

}
