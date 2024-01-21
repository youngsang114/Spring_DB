package hello.jdbc.service;

import hello.jdbc.domain.Member;
import hello.jdbc.repository.MemberRepositoryV2;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * 트랜잭션 -  파라미터를 연동, 풀을 고려한 종료
 */
@Slf4j
@RequiredArgsConstructor
public class MemberServiceV2 {

    private final DataSource dataSource;
    private final MemberRepositoryV2 memberRepository;

    public void accountTransfer(String fromId, String toId, int money) throws SQLException {

        Connection con = dataSource.getConnection();
        try {
            con.setAutoCommit(false); // 트랜잭션 시작
            bizLogic(con, fromId, toId, money);
            con.commit(); // 성공시 -> 커밋 후 트랜잭션 종료
            // 커밋, 롤백 중 판단!
        } catch (Exception e){
            con.rollback(); // 실패시 롤백
            throw new IllegalStateException(e);
        } finally {
            release(con);
        }
    }

    private void bizLogic(Connection con, String fromId, String toId, int money) throws SQLException {
        // 비지니스 로직을 수행
        Member fromMember = memberRepository.findById(con, fromId);
        Member toMember = memberRepository.findById(con, toId);

        memberRepository.update(con, fromId,fromMember.getMoney()- money);
        validation(toMember);
        memberRepository.update(con, toId,toMember.getMoney()+ money);
    }

    private static void release(Connection con) {
        if (con != null){
            try {
                con.setAutoCommit(true); // 다시 기본값으로 수정해주자 -> 커넥션 풀 고려!!!
                con.close();
            } catch (Exception e){
                log.error("error",e);
            }
        }
    }

    private static void validation(Member toMember) {
        if (toMember.getMemberId().equals("ex")){
            throw new IllegalStateException("이체중 예외 발생");
        }
    }
}
