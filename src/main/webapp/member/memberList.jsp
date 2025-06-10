<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.gungon.pagination.PaginationBuilder" %>
<%@ page import="kr.co.gungon.admin.AdminDAO" %>
<%@ page import="kr.co.gungon.member.MemberDTO" %>
<%@ page import="java.util.List" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
    String deleted = request.getParameter("deleted");
    if ("1".equals(deleted)) {
%>
<script>alert("회원이 탈퇴 처리되었습니다.");</script>
<%
    }

    AdminDAO dao = AdminDAO.getInstance();
    int rowCount = dao.getMemberCount(); // 전체 회원 수
    int pageSize = 5; // 페이지 당 회원 수

    kr.co.gungon.pagination.PaginationBuilder pagination =
        new PaginationBuilder(request, pageSize, rowCount);

    int start = (pagination.getCurrentPage() - 1) * pageSize + 1;
    int end = pagination.getCurrentPage() * pageSize;

    List<MemberDTO> memberList = dao.getMemberList(start, end);
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
<div id="layoutSidenav_content">

<script type="text/javascript">
$(function(){
    $('#mem_search_form').submit(function(event){
      event.preventDefault(); // 폼 전송 막기

        if ($('#keyword').val().trim() === '') {
            alert('검색어를 입력하세요');
            $('#keyword').val('').focus();
            return false;
        }

        let form_data = $(this).serialize();

        $.ajax({
        	url: '${pageContext.request.contextPath}/member/memberSearchAjax.jsp',
            type: 'get',
            data: form_data,
            dataType: 'json',
            success: function(param){
                $('#member-data').empty();
                $('#pagination-area').empty();

                if (!param.list || param.list.length === 0) {
                    $('#member-data').html('<tr><td colspan="6" style="text-align:center;">존재하지 않는 회원입니다.</td></tr>');
                } else {
                    let output = '';
                    $(param.list).each(function(index, item){
                        let flagText = item.flag === 'Y' ? '탈퇴' : '정상';
                        let rowStyle = item.flag === 'Y' ? 'style="color:gray; cursor:default;"' : 'style="cursor:pointer;"';
                        let clickable = item.flag === 'Y' ? '' : `onclick="location.href='memberDetail.jsp?id=${item.id}'"`;

                        output += `<tr ${rowStyle} ${clickable}>`;
                        output += `<td>${item.name}</td>`;
                        output += `<td>${item.id}</td>`;
                        output += `<td>${item.tel}</td>`;
                        output += `<td>${item.useEmail}</td>`;
                        output += `<td>${item.input_date}</td>`;
                        output += `<td>${flagText}</td>`;
                        output += `</tr>`;
                    });
                    $('#member-data').html(output);
                    $('#pagination-area').html(param.page);
                }
            },
            error: function(){
                alert('검색 중 오류 발생');
            }
        });
    });
});
</script>

    <main>
        <div class="container-fluid px-4">
            <h2 class="mt-4">회원 관리</h2>
            <hr/>
        
        <div class="card m-3"><!-- card m-3 start -->
        <div class="card-body"><!-- card-body start -->
        <h2>회원 목록</h2>
        <div class="main-search">
				<!-- 검색 시작 -->
				<form id="mem_search_form" method="get" action="memberList.jsp">
					<div class="main-search">
						<ul class="search">
							<li>
								<select name="keyfield" style="height: 30px;">
									<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>이름</option>
									<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>아이디</option>
									<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>이메일</option>
								</select>
								<input type="search" size="10" name="keyword" id="keyword" 
												value="${param.keyword}" placeholder="검색어를 입력하세요">
								<input type="submit" value="검색" style="height: 30px;">
							</li>
						</ul>
					</div>
				</form>
				</div>
				<!-- 검색 결과/목록이 들어갈 영역 -->
            <div id="change-memlist"> 
    <table class="table table-bordered table-hover">
        <thead class="table-light">
        <tr>
            <th>이름</th>
            <th>아이디</th>
            <th>전화번호</th>
            <th>이메일</th>
            <th>가입일</th>
            <th>탈퇴여부</th>
        </tr>
        </thead>
        <tbody id="member-data">
        <%
            for(MemberDTO dto : memberList){
                boolean isDeleted = "Y".equals(dto.getFlag());
                String rowStyle = isDeleted ? "color:gray; cursor:default;" : "cursor:pointer;";
                String link = request.getContextPath() + "/member/memberDetail.jsp?id=" + dto.getId();
        %>
            <tr
                class="<%= isDeleted ? "disabled" : "" %>"
                style="<%= rowStyle %>"
                <%= !isDeleted ? "onclick=\"location.href='" + link + "'\"" : "" %>>
                <td><%= dto.getName() %></td>
                <td><%= dto.getId() %></td>
                <td><%= dto.getTel() %></td>
                <td><%= dto.getUseEmail() %></td>
                <td><%= dto.getInput_date() %></td>
                <td><%= isDeleted ? "탈퇴" : "정상" %></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <!-- 페이지네이션 표시 -->
    <div class="mem-page" id="pagination-area">
        <%= pagination.build("memberList.jsp") %>
    </div>
</div>

        </div><!-- card-body end -->
        </div><!-- card m-3 end -->
    </main>

<%@ include file="/admin/common/footer.jsp" %>

<script>
    document.querySelectorAll("tr.disabled").forEach(function(row) {
        row.addEventListener("click", function() {
            alert("탈퇴한 회원은 조회가 불가능합니다.");
        });
    });
</script>