package test.dto;

import java.sql.Timestamp;
import java.util.Date;

public class Com1EmpLogDto {
	private int logid; // 로그 ID
	private int empno; // 직원 번호
	private Timestamp checkIn; // 출근 시간
	private Timestamp checkOut; // 퇴근 시간
	private Date workingDate; // 근무 날짜
	private double workingHours; // 근무 시간
	private double overtime; // 초과 근무 시간
	private String remarks; // 비고
	private String month; //월
	//페이징 처리할 때 필요한 필드
	private int startRowNum;
	private int endRowNum;
	private long prevNum; //이전글의 글번호
	private long nextNum; //다음글의 글번호
	//수정
	
	public int getLogid() {
		return logid;
	}
	public void setLogid(int logid) {
		this.logid = logid;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public Timestamp getCheckIn() {
		return checkIn;
	}
	public void setCheckIn(Timestamp checkIn) {
		this.checkIn = checkIn;
	}
	public Timestamp getCheckOut() {
		return checkOut;
	}
	public void setCheckOut(Timestamp checkOut) {
		this.checkOut = checkOut;
	}
	public Date getWorkingDate() {
		return workingDate;
	}
	public void setWorkingDate(Date workingDate) {
		this.workingDate = workingDate;
	}
	public double getWorkingHours() {
		return workingHours;
	}
	public void setWorkingHours(double workingHours) {
		this.workingHours = workingHours;
	}
	public double getOvertime() {
		return overtime;
	}
	public void setOvertime(double overtime) {
		this.overtime = overtime;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getStartRowNum() {
		return startRowNum;
	}
	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}
	public int getEndRowNum() {
		return endRowNum;
	}
	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}
	public long getPrevNum() {
		return prevNum;
	}
	public void setPrevNum(long prevNum) {
		this.prevNum = prevNum;
	}
	public long getNextNum() {
		return nextNum;
	}
	public void setNextNum(long nextNum) {
		this.nextNum = nextNum;
	}
	

	
}