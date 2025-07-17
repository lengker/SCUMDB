package exception;

public class LoginException extends Exception {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    public LoginException() {
        super();

    }

    public LoginException(String message, Throwable cause) {
        super(message, cause);

    }

    public LoginException(String message) {
        super(message);
        // TODO Auto-generated constructor stub
    }

    public LoginException(Throwable cause) {
        super(cause);
        // TODO Auto-generated constructor stub
    }

}
