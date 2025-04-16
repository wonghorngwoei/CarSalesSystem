package facade;

import java.util.stream.Collectors;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import model.Feedback;

@Stateless
public class FeedbackFacade extends AbstractFacade<Feedback> {

    @PersistenceContext(unitName = "EnterpriseApplication1-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FeedbackFacade() {
        super(Feedback.class);
    }

    public int countFeedbackByRating(String rating) {
        return findAll().stream()
                .filter(f -> f.getRating().equalsIgnoreCase(rating))
                .collect(Collectors.toList())
                .size();
    }

}
