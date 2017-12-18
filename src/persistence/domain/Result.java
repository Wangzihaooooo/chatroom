package persistence.domain;

public class Result {

    /**
     *  "1" response with success
     */
    public static final String SUCCESS = "1";

    /**
     * "0" response with failure
     */
    public static final String FAILURE = "0";

    private String status;

    public static String getFAILURE() {
        return FAILURE;
    }

    public static String getSUCCESS() {

        return SUCCESS;
    }

    private String message;



    public Result() {
        super();
    }

    public Result(String status, String message) {
        super();
        this.status = status;
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }


}