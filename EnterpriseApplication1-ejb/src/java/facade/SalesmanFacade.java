package facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import model.Salesman;

@Stateless
public class SalesmanFacade extends AbstractFacade<Salesman> {

    @PersistenceContext(unitName = "EnterpriseApplication1-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SalesmanFacade() {
        super(Salesman.class);
    }

    public Salesman findBySalesmanUsername(String username) {
        try {
            return em.createQuery("SELECT s FROM Salesman s WHERE s.username = :username", Salesman.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public Salesman loginAsSalesman(String id, String password) {
        Salesman salesman = findBySalesmanUsername(id);
        if (salesman != null && salesman.getPassword().equals(password)) {
            return salesman;
        }
        return null;
    }

    public List<Salesman> searchSalesman(String keyword) {
        return em.createQuery("SELECT s FROM Salesman s WHERE s.usertype = 'salesman' AND (LOWER(s.username) LIKE :keyword "
                + "OR LOWER(s.name) LIKE :keyword "
                + "OR LOWER(s.email) LIKE :keyword "
                + "OR LOWER(s.gender) LIKE :keyword "
                + "OR LOWER(s.hpnumber) LIKE :keyword "
                + "OR LOWER(s.status) LIKE :keyword)", Salesman.class)
                .setParameter("keyword", "%" + keyword.toLowerCase() + "%")
                .getResultList();
    }

    public List<Salesman> findAllSalesman() {
        return em.createQuery("SELECT s FROM Salesman s WHERE s.usertype = 'salesman'", Salesman.class)
                .getResultList();
    }

    public Long findSalesmanGenderCount(String gender) {
        return em.createQuery("SELECT COUNT(s) FROM Salesman s WHERE s.gender = :gender", Long.class)
                .setParameter("gender", gender)
                .getSingleResult();
    }
}
