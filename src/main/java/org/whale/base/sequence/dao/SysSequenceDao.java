package org.whale.base.sequence.dao;

import org.springframework.stereotype.Repository;
import org.whale.base.sequence.domain.SysSequence;
import org.whale.system.dao.BaseDao;

@Repository
public class SysSequenceDao extends BaseDao<SysSequence, Long> {

	public static final String GET_CURRENT_VAL = "SELECT * from SYS_SEQUENCE WHERE SEQ_TYPE = ? ";
	public SysSequence getCurrentSequence(Long seqType) {
		return this.jdbcTemplate.queryForObject(GET_CURRENT_VAL, new Object[]{seqType}, this.getRowMapper());
	}
	
}

