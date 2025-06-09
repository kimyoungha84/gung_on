<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">
                    <div class="sb-sidenav-menu-heading">관리자 메뉴</div>

                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/adminMain.jsp">대시보드</a>

                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseGung">
                        궁 관리
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseGung">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/admin_gung/gung_list.jsp">궁 목록</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/admin_gung/story_list.jsp">궁 이야기</a>
                        </nav>
                    </div>

                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseEvent">
                        행사 관리
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseEvent">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="#">세부메뉴 1</a>
                            <a class="nav-link" href="#">세부메뉴 2</a>
                        </nav>
                    </div>

                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseTicket">
                        예매 관리
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseTicket">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="${pageContext.request.contextPath}/ticket/ticketAdmin/manageFrm.jsp">예매 목록</a>
                        </nav>
                    </div>

                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseView">
                        코스 관리
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseView">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/admin_course/course_main.jsp">사용자 추천코스 관리</a>
                        </nav>
                    </div>

                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseMember">
                        회원 관리
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseMember">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="${pageContext.request.contextPath}/member/memberList.jsp">회원 목록</a>
                        </nav>
                    </div>

                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseCS">
                        고객센터 관리
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseCS">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/admin_cs/cs_notice_main.jsp">공지사항</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/admin_cs/cs_faq_main.jsp">FAQ</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/admin_cs/cs_inquiry_main.jsp">1:1 문의</a>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="sb-sidenav-footer text-center">
                <div class="mb-2">관리자</div>
                <form action="${pageContext.request.contextPath}/admin/adminLogout.jsp" method="post">
                    <button type="submit" class="logout-btn">로그아웃</button>
                </form>
            </div>
        </nav>
    </div>