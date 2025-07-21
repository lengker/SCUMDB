package dao;

import domain.Movie;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DataSourceUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: MovieDao.java
 * @Description: TODO(处理与 allmovies表相关的操作)
 * @version: V1.0
 */
public class MovieDao {

    /**
     * @return 所有电影的集合
     * @Description: TODO(查找所有电影)
     */
    public List<Movie> findAllMovies() throws SQLException {
        String sql = "SELECT * FROM allmovies WHERE id IN (SELECT MIN(id) FROM allmovies GROUP BY name) ORDER BY name";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<>(Movie.class));
    }


    /**
     * @param params 电影种类
     * @return 对应种类的电影
     * @Description: TODO 根据电影种类查找12部电影
     */
    public List<Movie> findMoviesByCategoryWithLimit(Object... params) throws SQLException {
        String sql = "select * from allmovies where type = ? limit 0,12";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class), params);
    }


    /**
     * @param movie 被修改的电影
     * @Description: TODO(修改电影信息)
     */
    public boolean updateMovie(Movie movie, String originName) throws SQLException {
        String sql = "UPDATE allmovies SET name=?, score=?, director=?, scriptwriter=?, actor=?, " +
            "years=?, country=?, languages=?, length=?, image=?, des=?, url=?, type=? " +
            "WHERE name=?";

        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        int result = runner.update(sql,
            movie.getName(),
            movie.getScore(),
            movie.getDirector(),
            movie.getScriptwriter(),
            movie.getActor(),
            movie.getYears(),
            movie.getCountry(),
            movie.getLanguages(),
            movie.getLength(),
            movie.getImage(),
            movie.getDes(),
            movie.getUrl(),
            movie.getType(),
            originName
        );

        return result > 0;
    }

    /**
     * 通过电影年份和种类查找对应的电影
     *
     * @param year 电影年份
     * @param type 电影种类
     * @param page 当前显示页
     * @return java.util.List<domain.Movie>
     */
    public List<Movie> findMovieByYearAndCatrgory(String type, String year, int page) throws SQLException {
        String sql = "select * from allmovies where type = ? and years = ? limit ?, ?";
        Object[] params = new Object[]{type, year, (page - 1) * 12, (page * 12)};
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class), params);
    }

    /**
     * @param movieName
     * @return
     * @Description: TODO(根据电影名查找电影对应的所有类型)
     */
    public List<String> findMovieTypeByName(String movieName) {
        return null;

    }

    /**
     * @param movie
     * @Description: TODO(添加电影)
     */
    public void addMovie(Movie movie) throws SQLException {
        String sql = "insert into allmovies (id,name, score, director, scriptwriter, actor, years, country, languages," +
            "length, image, des, url, type) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql, movie.getId(), movie.getName(), movie.getScore(), movie.getDirector(), movie.getScriptwriter(),
            movie.getActor(), movie.getYears(), movie.getCountry(), movie.getLanguages(), movie.getLength(), movie.getImage(),
            movie.getDes(), movie.getUrl(), movie.getType());
    }

    /**
     * @param movieName 要删除电影的名字
     * @Description: TODO(根据电影名字删除电影)
     */
    public void deleteMovieByName(String movieName) throws SQLException {
        String sql = "delete from allmovies where name = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql, movieName);
    }

    /**
     * @param condition 查找的条件
     * @return
     * @throws SQLException
     * @Description: 根据模糊电影名查找电影
     */
    public List<Movie> findMoviesByDimName(String condition) throws SQLException {
        String sql = "SELECT * FROM allmovies WHERE name LIKE ? LIMIT 20";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        List<Movie> allMovies = runner.query(sql, new BeanListHandler<Movie>(Movie.class), "%"+condition+"%");

        // 在Java层面去重，保留评分最高的版本
        List<Movie> uniqueMovies = new ArrayList<>();
        for (Movie movie : allMovies) {
            boolean exists = false;
            for (Movie uniqueMovie : uniqueMovies) {
                if (uniqueMovie.getName().equals(movie.getName())) {
                    // 如果已存在同名电影，保留评分更高的
                    if (movie.getScore() > uniqueMovie.getScore()) {
                        uniqueMovies.remove(uniqueMovie);
                        uniqueMovies.add(movie);
                    }
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                uniqueMovies.add(movie);
            }
        }

        // 按评分排序并限制返回8个结果
        uniqueMovies.sort((m1, m2) -> Double.compare(m2.getScore(), m1.getScore()));
        if (uniqueMovies.size() > 8) {
            return uniqueMovies.subList(0, 8);
        }

        return uniqueMovies;
    }

    /**
     * @param movieName 电影名
     * @return Movie
     * @throws SQLException
     * @Description: 根据电影名查找电影
     */
    public Movie findMovieByName(String movieName) throws SQLException {
        String sql = "select * from allmovies where name= ? limit 1";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanHandler<Movie>(Movie.class), movieName);
    }


    /**
     * 查找对应电影种类的数量
     *
     * @param category 电影种类
     * @return 电影种类的数量
     */
    public int findMoviesNumberByCategory(String category) throws SQLException {
        String sql = "select count(*) from allmovies where type = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        Long count = runner.query(sql, new ScalarHandler<Long>(), category);
        return Integer.parseInt(count.toString());
    }

    /**
     * 获取对应种类电影的部分数据，从第几行开始取决于page
     *
     * @param type 电影种类
     * @param page 分页数
     * @return 电影集合
     */
    public List<Movie> findMoviesWithTypeAndPage(String type, int page) throws SQLException {
        String sql = "select * from allmovies where type = ? limit ?, ?";
        Object[] params = new Object[]{type, ((page - 1) * 12), (page * 12)};
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class), params);
    }

    /**
     * 查找对应年份和种类的电影数量
     *
     * @param type 电影种类
     * @param year 电影年份
     * @return int 电影数量
     */
    public int findMoviesCountByTypeAndYear(String type, String year) throws SQLException {
        String sql = "select count(*) from allmovies where type = ? and years = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        Long count = runner.query(sql, new ScalarHandler<Long>(), type, year);
        return Integer.parseInt(count.toString());
    }


    /**
     * 统计对应电影种类和出版国家的电影数量
     *
     * @param country  电影国家
     * @param category 电影种类
     * @return int
     */
    public int getMoviesCountByCountryAndCategory(String country, String category) throws SQLException {
        country = "%" + country + "%";
        String sql = "select count(*) from allmovies where country like ? and type=?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        Long count = runner.query(sql, new ScalarHandler<Long>(), country, category);
        return Integer.parseInt(count.toString());
    }

    /**
     * 根据电影出版国家和种类来查找电影
     *
     * @param country  电影国家
     * @param category 电影种类
     * @return java.util.List<domain.Movie>
     */
    public List<Movie> findMoviesByCountryAndCategory(String country, String category, int page) throws SQLException {
        country = "%" + country + "%";
        String sql = "select * from allmovies where type = ? and country like ? limit ?, ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class), category, country, (page - 1) * 12, (page * 12));
    }

    /**
     * 根据电影出版国家，年份和所属类型来查找对应的电影
     *
     * @param country  电影国家
     * @param category 电影种类
     * @param year     电影上映年份
     * @return java.util.List<domain.Movie>
     */
    public List<Movie> findMoviesByCountryAndYearAndCategory(String country, String category, String year, int page) throws SQLException {
        country = "%" + country + "%";
        String sql = "select * from allmovies where type = ? and country like ? and years = ? limit ?, ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class), category, country, year, (page - 1) * 12, (page * 12));
    }

    /**
     * 根据电影出版国家，年份和所属类型来统计符合条件的电影数量
     *
     * @param country  电影国家
     * @param category 电影种类
     * @param year     电影上映年份
     * @return 符合条件的电影数量
     */
    public int getMoviesCountByCountryAndYearAndCategory(String country, String category, String year) throws SQLException {
        country = "%" + country + "%";
        String sql = "select count(*) from allmovies where type = ? and country like ? and years = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        Long count = runner.query(sql, new ScalarHandler<Long>(), category, country, year);
        return Integer.parseInt(count.toString());
    }

    /**
     * 查找符合年份、评分和种类的电影
     *
     * @param year     电影上映年份
     * @param score    电影评分
     * @param category 电影种类
     * @param page     当前显示页数
     * @return java.util.List<domain.Movie>
     */
    public List<Movie> findMoviesByYearAndScoreAndCategory(String year, String score, String category, int page) throws SQLException {
        String sql = "select * from allmovies where years = ? and score > ? and type = ? limit ?, ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class), year, score, category, (page - 1) * 12, (page * 12));
    }

    /**
     * 查找符合年份、评分和种类的电影
     *
     * @param country  电影上映国家
     * @param score    电影评分
     * @param category 电影种类
     * @return java.util.List<domain.Movie>
     */
    public List<Movie> findMoviesByCountryAndScoreAndCategory(String country, String score, String category, int page) throws SQLException {
        String sql = "select * from allmovies where country = ? and score > ? and type = ? limit ?, ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class), country, score, category, (page - 1) * 12, (page * 12));
    }

    /**
     * 查找符合年份、评分和种类的电影
     *
     * @param year     电影上映年份
     * @param country  电影上映国家
     * @param score    电影评分
     * @param category 电影种类
     * @return java.util.List<domain.Movie>
     */
    public List<Movie> findMoviesByYearAndCountryAndScoreAndCategory(String year, String country, String score,
        String category, int page) throws SQLException {
        String sql = "select * from allmovies where years = ? and country = ? and score > ? and type = ? limit ?, ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class),
            year, country, score, category, (page - 1) * 12, (page * 12));

    }

    /**
     * 根据多个筛选条件查找电影
     *
     * @param type      电影类型
     * @param years     上映年份
     * @param country   上映国家
     * @param minScore  最低评分
     * @param sortBy    排序字段
     * @param sortOrder 排序方向 (ASC, DESC)
     * @return 电影集合
     */
    public List<Movie> findMoviesWithMultipleFilters(String type, String years, String country, String minScore,
        String sortBy, String sortOrder) throws SQLException {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM allmovies WHERE id IN (SELECT MIN(id) FROM allmovies WHERE 1=1");

        List<Object> params = new ArrayList<>();

        // 添加筛选条件
        if (type != null && !type.trim().isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type.trim());
        }

        if (years != null && !years.trim().isEmpty()) {
            sql.append(" AND years = ?");
            params.add(years.trim());
        }

        if (country != null && !country.trim().isEmpty()) {
            sql.append(" AND country LIKE ?");
            params.add("%" + country.trim() + "%");
        }

        if (minScore != null && !minScore.trim().isEmpty()) {
            try {
                Double.parseDouble(minScore.trim()); // 验证是否为有效数字
                sql.append(" AND score >= ?");
                params.add(minScore.trim());
            } catch (NumberFormatException e) {
                // 忽略无效的评分值
            }
        }

        sql.append(" GROUP BY name)");

        // 添加排序
        if (sortBy != null && !sortBy.isEmpty()) {
            sql.append(" ORDER BY ").append(sortBy);
            if (sortOrder != null && !sortOrder.isEmpty()) {
                sql.append(" ").append(sortOrder);
            }
        } else {
            sql.append(" ORDER BY name");
        }

        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql.toString(), new BeanListHandler<Movie>(Movie.class), params.toArray());
    }

    /**
     * 查找符合评分和种类条件的电影
     *
     * @param score    电影评分
     * @param category 电影类型
     * @return java.util.List<domain.Movie>
     */
    public List<Movie> findMoviesByScoreAndCategory(String score, String category, int page) throws SQLException {
        String sql = "select * from allmovies where score > ? and type = ? limit ?, ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class), score, category,
            (page - 1) * 12, (page * 12));
    }

    /**
     * 统计符合年份和评分、种类条件的电影数量
     *
     * @param year     电影上映年份
     * @param score    电影评分
     * @param category 电影种类
     * @return int
     */
    public int getMoviesCountByYearAndScoreAndCategory(String year, String score, String category) throws SQLException {
        String sql = "select count(*) from allmovies where years = ? and score > ? and type = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        Long count = runner.query(sql, new ScalarHandler<Long>(), year, score, category);
        return Integer.parseInt(count.toString());
    }

    /**
     * 统计符合国家和评分、种类条件的电影数量
     *
     * @param country  电影国家
     * @param score    电影评分
     * @param category 电影种类
     * @return int
     */
    public int getMoviesCountByCountryAndScoreAndCategory(String country, String score, String category) throws SQLException {
        String sql = "select count(*) from allmovies where country = ? and score > ? and type = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        Long count = runner.query(sql, new ScalarHandler<Long>(), country, score, category);
        return Integer.parseInt(count.toString());
    }

    /**
     * 统计符合年份、国家、评分和种类条件的电影数量
     *
     * @param year     电影上映年份
     * @param country  电影国家
     * @param score    电影评分
     * @param category 电影种类
     * @return int
     */
    public int getMoviesCountByYearAndCountryAndScoreAndCategory(String year, String country, String score, String category) throws SQLException {
        String sql = "select count(*) from allmovies where years = ? and country = ? and score > ? and type = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        Long count = runner.query(sql, new ScalarHandler<Long>(), year, country, score, category);
        return Integer.parseInt(count.toString());
    }

    /**
     * 统计符合评分和种类的电影数量
     *
     * @param score    电影评分
     * @param category 电影种类
     * @return int
     */
    public int getMoviesCountByScoreAndCategory(String score, String category) throws SQLException {
        String sql = "select count(*) from allmovies where score > ? and type = ?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        Long count = runner.query(sql, new ScalarHandler<Long>(), score, category);
        return Integer.parseInt(count.toString());
    }
        /**
         * 获取电影总数
         *
         * @return long
         */
        public long getMoviesCount() throws SQLException {
            String sql = "select count(*) from allmovies";
            QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
            return (long) runner.query(sql, new ScalarHandler());
        }

        /**
         * 获取按类型划分的电影数量
         *
         * @return List<Map<String, Object>>
         */
        public List<Map<String, Object>> getMovieTypeDistribution() throws SQLException {
            String sql = "SELECT type, COUNT(*) AS count FROM allmovies GROUP BY type";
            QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
            return runner.query(sql, new MapListHandler());
        }


    /**
     * 得到最大的电影 id
     *
     * @return int
     */
    public int getMaxMovieId() throws SQLException {
        String sql = "select id from allmovies ORDER BY id desc LIMIT 0,1";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        int count = (int) runner.query(sql, new ScalarHandler<>("id"));
        System.out.println(count + "xxxxxxxxxxxxxxx");
        return count;
    }




}
