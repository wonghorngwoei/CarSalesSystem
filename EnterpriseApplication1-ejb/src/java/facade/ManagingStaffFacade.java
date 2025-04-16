package facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import model.ManagingStaff;

@Stateless
public class ManagingStaffFacade extends AbstractFacade<ManagingStaff> {

    @PersistenceContext(unitName = "EnterpriseApplication1-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ManagingStaffFacade() {
        super(ManagingStaff.class);
    }

    public List<ManagingStaff> findAllManagingStaff() {
        return em.createQuery("SELECT m FROM ManagingStaff m WHERE m.usertype = 'managingStaff'", ManagingStaff.class)
                .getResultList();
    }

    public List<ManagingStaff> searchManagingStaff(String keyword) {
        return em.createQuery("SELECT m FROM ManagingStaff m WHERE LOWER(m.username) LIKE :keyword "
                + "OR LOWER(m.name) LIKE :keyword "
                + "OR LOWER(m.email) LIKE :keyword "
                + "OR LOWER(m.hpnumber) LIKE :keyword ", ManagingStaff.class)
                .setParameter("keyword", "%" + keyword.toLowerCase() + "%")
                .getResultList();
    }

    public ManagingStaff findByMgmtStaffUsername(String username) {
        try {
            return em.createQuery("SELECT m FROM ManagingStaff m WHERE m.username = :username", ManagingStaff.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public ManagingStaff loginAsManagingStaff(String username, String password) {
        ManagingStaff manager = findByMgmtStaffUsername(username);
        if (manager != null && manager.getPassword().equals(password)) {
            return manager;
        }
        return null;
    }

}
