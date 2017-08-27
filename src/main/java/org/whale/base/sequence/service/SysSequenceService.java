package org.whale.base.sequence.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.whale.base.TimeUtil;
import org.whale.base.sequence.dao.SysSequenceDao;
import org.whale.base.sequence.domain.SysSequence;
import org.whale.base.sequence.domain.SysSequence.SeqType;
import org.whale.system.dao.BaseDao;
import org.whale.system.service.BaseService;

/**
 *  序列管理
 *
 * @Date 2014-12-21
 */
@Service
public class SysSequenceService extends BaseService<SysSequence, Long> {

	@Autowired
	private SysSequenceDao sysSequenceDao;
	
	@Override
	public BaseDao<SysSequence, Long> getDao() {
		return sysSequenceDao;
	}

	/**
	 * 获得流水号
	 * @param seqType 参见SysSequence类定义序列类型
	 * @return
	 */
	public String doGetNextVal(SeqType seqType) {
		synchronized(SysSequence.SEQ_LOCK.get(seqType.getValue())){
			SysSequence currentSequence = sysSequenceDao.getCurrentSequence(seqType.getValue());
			Date now = new Date();
			if(TimeUtil.compareToDay(currentSequence.getCurDate(), now) == 0){
				currentSequence.setCurrentValue(currentSequence.getCurrentValue() + 1);
			} else{
				currentSequence.setCurDate(now);
				currentSequence.setCurrentValue(1l);
			}
			sysSequenceDao.update(currentSequence);
			return seqType.getPrefix() + TimeUtil.getCurrDate("yyyyMMdd") + String.format("%03d", currentSequence.getCurrentValue());
		}
	}
	
}