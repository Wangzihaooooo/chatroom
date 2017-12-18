package persistence.mapper;

import persistence.domain.Record;

public interface RecordMapper {
    int deleteByPrimaryKey(Integer recordId);

    int insert(Record record);

    int insertSelective(Record record);

    Record selectByPrimaryKey(Integer recordId);

    int updateByPrimaryKeySelective(Record record);

    int updateByPrimaryKeyWithBLOBs(Record record);

    int updateByPrimaryKey(Record record);
}