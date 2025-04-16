package facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import model.Customer;
import model.Salesman;
import model.Transactions;

@Stateless
public class TransactionsFacade extends AbstractFacade<Transactions> {

    @PersistenceContext(unitName = "EnterpriseApplication1-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TransactionsFacade() {
        super(Transactions.class);
    }

    public List<Transactions> findAllTransactionsBySalesman(Salesman salesman) {
        return em.createQuery("SELECT t FROM Transactions t WHERE t.salesman = :salesman", Transactions.class)
                .setParameter("salesman", salesman)
                .getResultList();
    }

    public Transactions findTransactionByCarId(Long id) {
        return em.createQuery("SELECT t FROM Transactions t WHERE t.car.id = :id", Transactions.class)
                .setParameter("id", id)
                .getSingleResult();
    }

    public List<Transactions> findAllTransactionsByCustomer(Customer customer) {
        return em.createQuery("SELECT t FROM Transactions t WHERE t.customer = :customer", Transactions.class)
                .setParameter("customer", customer)
                .getResultList();
    }

    public Long findTransactionsStatusCount(String transStatus) {
        return em.createQuery("SELECT COUNT(t) FROM Transactions t WHERE t.transStatus = :transStatus", Long.class)
                .setParameter("transStatus", transStatus)
                .getSingleResult();
    }

    public List<Transactions> findAllTransactions() {
        return em.createQuery("SELECT t FROM Transactions t", Transactions.class)
                .getResultList();
    }

}
