package facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import model.Customer;

@Stateless
public class CustomerFacade extends AbstractFacade<Customer> {

    @PersistenceContext(unitName = "EnterpriseApplication1-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CustomerFacade() {
        super(Customer.class);
    }

    public Customer findByCustomerUsername(String username) {
        try {
            return em.createQuery("SELECT c FROM Customer c WHERE c.username = :username", Customer.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public Customer loginAsCustomer(String username, String password) {
        Customer customer = findByCustomerUsername(username);
        if (customer != null && customer.getPassword().equals(password)) {
            return customer;
        }
        return null;
    }

    public List<Customer> searchCustomer(String keyword) {
        return em.createQuery("SELECT c FROM Customer c WHERE LOWER(c.username) LIKE :keyword "
                + "OR LOWER(c.name) LIKE :keyword "
                + "OR LOWER(c.email) LIKE :keyword "
                + "OR LOWER(c.gender) LIKE :keyword "
                + "OR LOWER(c.hpnumber) LIKE :keyword ", Customer.class)
                .setParameter("keyword", "%" + keyword.toLowerCase() + "%")
                .getResultList();
    }

    public List<Customer> findAllCustomer() {
        return em.createQuery("SELECT c FROM Customer c WHERE c.usertype = 'customer'", Customer.class)
                .getResultList();
    }

    public Long findCustomerGenderCount(String gender) {
        return em.createQuery("SELECT COUNT(c) FROM Customer c WHERE c.gender = :gender", Long.class)
                .setParameter("gender", gender)
                .getSingleResult();
    }

}
