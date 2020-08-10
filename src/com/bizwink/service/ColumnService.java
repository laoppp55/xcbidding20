package com.bizwink.service;

import com.bizwink.persistence.ColumnMapper;
import com.bizwink.po.Column;
import com.bizwink.po.ColumnIDS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 17-5-12.
 */
@Service
public class ColumnService {
    @Autowired
    private ColumnMapper columnMapper;

    public String  getColumns(BigDecimal siteid) {
        List<Column> columns= columnMapper.getColumnsBySiteid(siteid);

        String buf = null;
        if (columns.size() > 0) {
            buf = "[\r\n";
            for(int ii=0;ii<columns.size();ii++){
                Column column = (Column)columns.get(ii);
                buf = buf + "{id:" + column.getID().intValue() + ",pId:"+ column.getPARENTID().intValue() + ",name:\"" + column.getCNAME() +"\",url:\"\"" + ",open:\"true\"" +"},\r\n";
            }
            buf = buf + "]";
        }

        return buf;
    }

    public List<Column>  getSubColumns(BigDecimal columnid) {
        return columnMapper.getSubColumnsByParentID(columnid);
    }

    public List<Integer> getSubColumnIDCollection(BigDecimal columnid) {
        List<Integer> ids = new ArrayList<Integer>();
        List<Integer> column_ids = new ArrayList<Integer>();

        ids.add(columnid.intValue());
        int count = 0;
        while(ids.size()>0) {
            int colid = ids.get(0);
            System.out.println(colid);
            ids.remove(0);
            List<ColumnIDS> colids = columnMapper.getSubColumnIdsByParentID(BigDecimal.valueOf(colid));
            for(int ii=colids.size()-1;ii>=0;ii--) {
                ColumnIDS columnIDS = colids.get(ii);
                count = count + 1;
                ids.add(0,columnIDS.getID().intValue());
            }
        }

        return ids;
    }

    public int getTrainType(BigDecimal columnid) {
        List<Integer> ids = new ArrayList<Integer>();
        int traintype = 0;

        //判断是否是注册类培训
        ids.add(74);
        int count = 0;
        while(ids.size()>0) {
            int colid = ids.get(0);
            if (colid==columnid.byteValue())  {
                traintype = 1;                               //表示注册类培训
                break;
            }
            ids.remove(0);
            List<ColumnIDS> colids = columnMapper.getSubColumnIdsByParentID(BigDecimal.valueOf(colid));
            for(int ii=colids.size()-1;ii>=0;ii--) {
                ColumnIDS columnIDS = colids.get(ii);
                count = count + 1;
                ids.add(0,columnIDS.getID().intValue());
            }
        }

        if (traintype == 0) {
            ids = new ArrayList<Integer>();
            ids.add(76);
            count = 0;
            while (ids.size() > 0) {
                int colid = ids.get(0);
                if (colid == columnid.byteValue()) {
                    traintype = 2;                               //现场管理人员培训
                    break;
                }
                ids.remove(0);
                List<ColumnIDS> colids = columnMapper.getSubColumnIdsByParentID(BigDecimal.valueOf(colid));
                for (int ii = colids.size() - 1; ii >= 0; ii--) {
                    ColumnIDS columnIDS = colids.get(ii);
                    count = count + 1;
                    ids.add(0, columnIDS.getID().intValue());
                }
            }
        }

        if (traintype == 0) {
            ids = new ArrayList<Integer>();
            ids.add(77);
            count = 0;
            while (ids.size() > 0) {
                int colid = ids.get(0);
                if (colid == columnid.byteValue()) {
                    traintype = 3;                               //现场操作人员培训
                    break;
                }
                ids.remove(0);
                List<ColumnIDS> colids = columnMapper.getSubColumnIdsByParentID(BigDecimal.valueOf(colid));
                for (int ii = colids.size() - 1; ii >= 0; ii--) {
                    ColumnIDS columnIDS = colids.get(ii);
                    count = count + 1;
                    ids.add(0, columnIDS.getID().intValue());
                }
            }
        }

        if (traintype == 0 && columnid.intValue()==75) traintype = 4;     //安全三类人培训

        return traintype;
    }

    public Column getColumn(BigDecimal columnid) {
        return columnMapper.selectByPrimaryKey(columnid);
    }
}
