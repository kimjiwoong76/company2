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
package egovframework.example.sample.web;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
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

@Controller
public class EgovSampleController {

	/** EgovSampleService */
	@Resource(name = "sampleService")
	private EgovSampleService sampleService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	Logger logger = LogManager.getLogger(EgovSampleController.class);
	
	
	@RequestMapping(value = "/test.do")
	public String test(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model, HttpServletRequest req, SampleVO sampleVO) {
		return "sample/grid";
	}
	
	@RequestMapping("/test2.do")
	@ResponseBody
	public ModelAndView test2(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model, HttpServletRequest req, SampleVO sampleVO) {
		ModelAndView mav = new ModelAndView();
		try {
			List<?> sampleList = sampleService.selectSampleList2(searchVO);
			int totCnt = sampleService.selectSampleListTotCnt(searchVO);
			mav.addObject("sampleList", sampleList);
			mav.addObject("total", totCnt);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return  mav;
	}
	
	
	@RequestMapping(value = "/grid.do")
	public @ResponseBody List<?> grid(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model, HttpServletRequest req, SampleVO sampleVO) throws Exception{
		
		List<?> sampleList = sampleService.selectSampleList2(sampleVO);
		System.out.println("sampleList = " + sampleList);
		return sampleList;
		
	}
	
	
	@RequestMapping(value = "/grid3.do")
	@ResponseBody
	public JSONObject grid3(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model, HttpServletRequest req, SampleVO sampleVO, HttpServletResponse response) throws Exception{
		
		Enumeration params = req.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +req.getParameter(name));
		}
		System.out.println("----------------------------");
		
		int totalCnt =  sampleService.selectSampleListTotCnt(searchVO);;
		List<?> sampleList = sampleService.selectSampleList2(sampleVO);
		JSONObject jsonObject = new JSONObject();
		JSONArray cell = new JSONArray();
		SampleVO sampleData = null;
		
		for(int i=0; i<sampleList.size(); i++) {
			System.out.println("sampleList = " + sampleList.get(i));
			sampleData = (SampleVO) sampleList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("id", sampleData.getId());
			obj.put("name", sampleData.getName());
			obj.put("description", sampleData.getDescription());
			obj.put("useYn", sampleData.getUseYn());
			System.out.println(sampleData.getUseYn());
			obj.put("regUser", sampleData.getRegUser());
			System.out.println(sampleData.getRegUser());
			cell.add(obj);			
			
		}
		
		
		jsonObject.put("total", totalCnt);
		jsonObject.put("page", "1");
		jsonObject.put("records", "10");
		jsonObject.put("rows", cell);
        System.out.println("### jsonObject : "+jsonObject);
		
		return jsonObject;
		
	}
		
	
		
	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	//@ResponseBody
	@RequestMapping(value = "/egovSampleList.do")
	public String selectSampleList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model, HttpServletRequest req, SampleVO sampleVO) throws Exception {
		
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		//** pageing setting *//*
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex() + 1);
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		List<?> sampleList = sampleService.selectSampleList(searchVO);
		model.addAttribute("resultList", sampleList);
		int totCnt = sampleService.selectSampleListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "sample/egovSampleList";
	}
	
	@RequestMapping(value = "/egovSampleListJson.do")
	public @ResponseBody Map<String, Object> getProgramHistoryList(HttpServletRequest request, SampleDefaultVO searchVO) throws Exception {
			Map<String, Object> param = new HashMap();
			param.put("rows", sampleService.selectSampleList(searchVO));
			param.put("result", "SUCCESS");
		return param;
	}
	

	/**
	 * 글 등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addSample.do", method = RequestMethod.GET)
	public String addSampleView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		model.addAttribute("sampleVO", new SampleVO());
		return "sample/egovSampleRegister";
	}

	/**
	 * 글을 등록한다.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addSample.do", method = RequestMethod.POST)
	public String addSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		// Server-Side Validation
		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "sample/egovSampleRegister";
		}

		sampleService.insertSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}

	/**
	 * 글 수정화면을 조회한다.
	 * @param id - 수정할 글 id
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping("/updateSampleView.do")
	public String updateSampleView(@RequestParam("selectedId") String id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		SampleVO sampleVO = new SampleVO();
		sampleVO.setId(id);
		// 변수명은 CoC 에 따라 sampleVO
		model.addAttribute(selectSample(sampleVO, searchVO));
		return "sample/egovSampleRegister";
	}

	/**
	 * 글을 조회한다.
	 * @param sampleVO - 조회할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */
	public SampleVO selectSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		return sampleService.selectSample(sampleVO);
	}

	/**
	 * 글을 수정한다.
	 * @param sampleVO - 수정할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/updateSample.do")
	public String updateSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status, HttpServletRequest req)
			throws Exception {
		
		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "sample/egovSampleRegister";
		}

		sampleService.updateSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}

	/**
	 * 글을 삭제한다.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/deleteSample.do")
	public String deleteSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus status) throws Exception {
		sampleService.deleteSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}
	
	
	/**
	 * 리스트에서 글을 삭제한다.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/deleteSampleAll.do"
	 * @exception Exception
	 */
	@RequestMapping("/deleteSampleAll.do")
	public String deleteSampleAll(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus status) {
		try {
			System.out.println("====================");
			String arr = sampleVO.getChkVal2();
			String[] arrs = arr.split(",");
			for(int i=0; i<arrs.length; i++) {
				System.out.println(arrs[i]);
			}
			System.out.println("====================");
			HashMap<String, Object> hm = new HashMap<String, Object>();
			hm.put("chkVal2", arrs);
			sampleService.deleteSample2(hm);
		}catch (Exception e) {
			logger.info(e);
		}
		
		return "forward:/egovSampleList.do";
	}
	
	
	@RequestMapping("oper.do")
	public String oper(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status, HttpServletRequest req)
			throws Exception {
		System.out.println(req.getParameter("oper"));
		String oper = req.getParameter("oper");
		if(oper.equals("del")) {
			System.out.println("delete");
			sampleService.deleteSample(sampleVO);
			status.setComplete();
			return "forward:/egovSampleList.do";
		} else {
			System.out.println("update");
			beanValidator.validate(sampleVO, bindingResult);

			if (bindingResult.hasErrors()) {
				model.addAttribute("sampleVO", sampleVO);
				return "sample/egovSampleRegister";
			}

			sampleService.updateSample(sampleVO);
			status.setComplete();
			return "forward:/egovSampleList.do";
		}
	}
	

}
