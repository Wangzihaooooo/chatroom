package persistence.mapper;

import org.apache.ibatis.annotations.Param;
import persistence.domain.Record;

import java.util.List;

public interface RecordMapper {
    int deleteByPrimaryKey(Integer recordId);

    int insert(Record record);

    int insertSelective(Record record);

    Record selectByPrimaryKey(Integer recordId);

    List<Record> selectByRelation(@Param("sender")String sender,
                                  @Param("recevier")String recevier);

    List<Record> selectToBroadcast(@Param("recevier")String recevier);

    int updateByPrimaryKeySelective(Record record);

    int updateByPrimaryKeyWithBLOBs(Record record);

    int updateByPrimaryKey(Record record);
}