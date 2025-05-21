package test.filter;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter({"/post/protected/*", "/companyone/*"})
public class LoginFilter implements Filter{
	
	//@WebFilter() 에 명시한 패턴의 요청을 하면 아래의 메소드가 호출된다.
	@Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
		//매개변수에 전달된 객체를 이용해서 자식 type 객체의 참조값을 얻어낸다.
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        //session 영역에서 로그인된 정보를 얻어내기 위한 객체
        HttpSession session = req.getSession();
        
        String role = (String)session.getAttribute("role");
        //만일 로그인을 하지 않았다면
        if (role == null) {
        	//로그인 페이지로 리다이렉트 시키는 메소드를 호출해서 리다이렉트 시킨다
        	//redirectToLogin(req, res);
            res.sendRedirect(req.getContextPath() + "/user/loginForm.jsp");
            return;
        }   

        //여기까지 실행의 흐름이 넘어오면 요청의 흐름을 계속 이어간다.
        chain.doFilter(request, response);
    }
	
	//리다이렉트(요청을 새로운 경로로 다시 하라는 응답) 응답을 하는 메소드
//    private void redirectToLogin(HttpServletRequest req, HttpServletResponse res) throws IOException {
//    	//원래 요청 url 을 읽어온다.
//        String url = req.getRequestURI();
//        //혹시 뒤에 query parameter 가 있다면 그것 역시 읽어온다.	?num=xxx&count=xxx
//        String query = req.getQueryString();
//        String encodedUrl = 
//        		query == null ?
//        		URLEncoder.encode(url, "UTF-8") :
//        		URLEncoder.encode(url + "?" + query, "UTF-8");
//        //로그인 페이지로 리다이렉트 이동하면서 원래 가려던 목적지 정보도 같이 넘겨준다.
//        res.sendRedirect(req.getContextPath() + "/user/loginForm.jsp?url=" + encodedUrl);
//    }
}
