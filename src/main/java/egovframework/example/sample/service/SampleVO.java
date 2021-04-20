/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.service;

import java.sql.Date;
import java.util.List;

/**
 * @Class Name : SampleVO.java
 * @Description : SampleVO Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
public class SampleVO extends SampleDefaultVO {

	private static final long serialVersionUID = 1L;

	private String id;
	private String name;
	private String description;
	private String useYn;
	private String regUser;
	private Date reg_date;
	private int c_rap;
	private String c_tub_type;
	private List<String> selectItem;
	private String orn;
	private String orderId;
	private String cInc;
	private double cSize;
	private String cType;
	private int tankVol;
	private String cOpts;
	private int status;
	private Date est_end_date;
	private String delYn;
	private String chkVal2;
	private int rows;
	private int page;
	
	
	
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public String getChkVal2() {
		return chkVal2;
	}
	public void setChkVal2(String chkVal2) {
		this.chkVal2 = chkVal2;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getRegUser() {
		return regUser;
	}
	public void setRegUser(String regUser) {
		this.regUser = regUser;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getC_rap() {
		return c_rap;
	}
	public void setC_rap(int c_rap) {
		this.c_rap = c_rap;
	}
	public String getC_tub_type() {
		return c_tub_type;
	}
	public void setC_tub_type(String c_tub_type) {
		this.c_tub_type = c_tub_type;
	}
	public List<String> getSelectItem() {
		return selectItem;
	}
	public void setSelectItem(List<String> selectItem) {
		this.selectItem = selectItem;
	}
	public String getOrn() {
		return orn;
	}
	public void setOrn(String orn) {
		this.orn = orn;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getcInc() {
		return cInc;
	}
	public void setcInc(String cInc) {
		this.cInc = cInc;
	}
	public double getcSize() {
		return cSize;
	}
	public void setcSize(double cSize) {
		this.cSize = cSize;
	}
	public String getcType() {
		return cType;
	}
	public void setcType(String cType) {
		this.cType = cType;
	}
	public int getTankVol() {
		return tankVol;
	}
	public void setTankVol(int tankVol) {
		this.tankVol = tankVol;
	}
	public String getcOpts() {
		return cOpts;
	}
	public void setcOpts(String cOpts) {
		this.cOpts = cOpts;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getEst_end_date() {
		return est_end_date;
	}
	public void setEst_end_date(Date est_end_date) {
		this.est_end_date = est_end_date;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
	
	

}
